# _setvar()
#
# Usage:
#   _setvar var value
#
# Set value in variable.
_setvar() {
  local _var="${1}"
  local _value="${2}"
  # Note: absence of leading space is must to set vairable properly.
  set +e
  read -rd '' $_var<<EOM
$_value
EOM
  set -e
}

# _extract_ip()
#
# Usage:
#   _extract_ip ip <host>
#
# Extract IP _extract_ip host
function _extract_ip() {
  local __resultvar_1="${1}"
  local __host="${2}"

  # extract the protocol
  local __proto="$(echo $__host | grep :// | sed -e's,^\(.*://\).*,\1,g')"
  # remove the protocol
  local __url="$(echo ${__host/$__proto/})"
  # Get docker daemon port.
  local __ip=$(echo "${__url}" | sed 's/^\(.*\):.*$/\1/g')

  _setvar $__resultvar_1 "${__ip}"
}