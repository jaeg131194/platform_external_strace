/* Generated by ./xlat/gen.sh from ./xlat/btrfs_features_compat_ro.in; do not edit. */
#if !(defined(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE) || (defined(HAVE_DECL_BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE) && HAVE_DECL_BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE))
# define BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE (1ULL << 0)
#endif

#ifdef IN_MPERS

extern const struct xlat btrfs_features_compat_ro[];

#else

# if !(defined HAVE_M32_MPERS || defined HAVE_MX32_MPERS)
static
# endif
const struct xlat btrfs_features_compat_ro[] = {
 XLAT_TYPE(uint64_t, BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE),
 XLAT_END
};

#endif /* !IN_MPERS */
