/* Generated by ./xlat/gen.sh from ./xlat/af_packet_types.in; do not edit. */

#ifdef IN_MPERS

# error static const struct xlat af_packet_types in mpers mode

#else

static
const struct xlat af_packet_types[] = {
#if defined(PACKET_HOST) || (defined(HAVE_DECL_PACKET_HOST) && HAVE_DECL_PACKET_HOST)
  XLAT(PACKET_HOST),
#endif
#if defined(PACKET_BROADCAST) || (defined(HAVE_DECL_PACKET_BROADCAST) && HAVE_DECL_PACKET_BROADCAST)
  XLAT(PACKET_BROADCAST),
#endif
#if defined(PACKET_MULTICAST) || (defined(HAVE_DECL_PACKET_MULTICAST) && HAVE_DECL_PACKET_MULTICAST)
  XLAT(PACKET_MULTICAST),
#endif
#if defined(PACKET_OTHERHOST) || (defined(HAVE_DECL_PACKET_OTHERHOST) && HAVE_DECL_PACKET_OTHERHOST)
  XLAT(PACKET_OTHERHOST),
#endif
#if defined(PACKET_OUTGOING) || (defined(HAVE_DECL_PACKET_OUTGOING) && HAVE_DECL_PACKET_OUTGOING)
  XLAT(PACKET_OUTGOING),
#endif
#if defined(PACKET_LOOPBACK) || (defined(HAVE_DECL_PACKET_LOOPBACK) && HAVE_DECL_PACKET_LOOPBACK)
  XLAT(PACKET_LOOPBACK),
#endif
#if defined(PACKET_FASTROUTE) || (defined(HAVE_DECL_PACKET_FASTROUTE) && HAVE_DECL_PACKET_FASTROUTE)
  XLAT(PACKET_FASTROUTE),
#endif
 XLAT_END
};

#endif /* !IN_MPERS */
