#!/bin/sh

usage() {
	cat <<EOF
Usage: $0 <input> <output>

Generate xlat header files from <input> (a file or dir of files) and write
the generated headers to <output>.
EOF
	exit 1
}

gen_header() {
	local input="$1" output="$2" name="$3"
	echo "generating ${output}"
	(
	local defs="${0%/*}/../defs.h"
	local prefix
	if grep -x "extern const struct xlat ${name}\\[\\];" "${defs}" > /dev/null; then
		prefix=
	else
		prefix='static '
	fi

	cat <<-EOF
		/* Generated by $0 from $1; do not edit. */

		${prefix}const struct xlat ${name}[] = {
	EOF
	local unconditional= unterminated= line
	while read line; do
		LC_COLLATE=C
		case ${line} in
		'#unconditional')
			unconditional=1
			;;
		'#unterminated')
			unterminated=1
			;;
		[A-Z_]*)	# symbolic constants
			local m="${line%%|*}"
			[ -n "${unconditional}" ] ||
				echo "#if defined(${m}) || (defined(HAVE_DECL_${m}) && HAVE_DECL_${m})"
			echo "	XLAT(${line}),"
			[ -n "${unconditional}" ] ||
				echo "#endif"
			;;
		'1<<'[A-Z_]*)	# symbolic constants with shift
			local m="${line#1<<}"
			[ -n "${unconditional}" ] ||
				echo "#if defined(${m}) || (defined(HAVE_DECL_${m}) && HAVE_DECL_${m})"
			echo "	{ ${line}, \"${m}\" },"
			[ -n "${unconditional}" ] ||
				echo "#endif"
			;;
		[0-9]*)	# numeric constants
			echo "	XLAT(${line}),"
			;;
		*)	# verbatim lines
			echo "${line}"
			;;
		esac
	done < "${input}"
	if [ -n "${unterminated}" ]; then
		echo "  /* this array should remain not NULL-terminated */"
	else
		echo "	XLAT_END"
	fi
	echo "};"
	) >"${output}"
}

gen_make() {
	local output="$1"
	local name
	shift
	echo "generating ${output}"
	(
		printf "XLAT_INPUT_FILES = "
		printf 'xlat/%s.in ' "$@"
		echo
		printf "XLAT_HEADER_FILES = "
		printf 'xlat/%s.h ' "$@"
		echo
		for name; do
			printf '$(top_srcdir)/xlat/%s.h: $(top_srcdir)/xlat/%s.in $(top_srcdir)/xlat/gen.sh\n' \
				"${name}" "${name}"
			echo '	$(AM_V_GEN)$(top_srcdir)/xlat/gen.sh $< $@'
		done
	) >"${output}"
}

gen_git() {
	local output="$1"
	shift
	echo "generating ${output}"
	(
		printf '/%s\n' .gitignore Makemodule.am
		printf '/%s.h\n' "$@"
	) >"${output}"
}

main() {
	case $# in
	0) set -- "${0%/*}" "${0%/*}" ;;
	2) ;;
	*) usage ;;
	esac

	local input="$1"
	local output="$2"
	local name

	if [ -d "${input}" ]; then
		local f names=
		for f in "${input}"/*.in; do
			[ -f "${f}" ] || continue
			name=${f##*/}
			name=${name%.in}
			gen_header "${f}" "${output}/${name}.h" "${name}" &
			names="${names} ${name}"
		done
		gen_git "${output}/.gitignore" ${names}
		gen_make "${output}/Makemodule.am" ${names}
		wait
	else
		name=${input##*/}
		name=${name%.in}
		gen_header "${input}" "${output}" "${name}"
	fi
}

main "$@"