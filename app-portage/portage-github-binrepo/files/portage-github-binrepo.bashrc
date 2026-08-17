# shellcheck shell=bash
# Source this file from /etc/portage/bashrc

_portage_github_binrepo_success() {
	[[ ${MERGE_TYPE:-} == source ]] || return 0
	# shellcheck disable=SC2086
	has buildpkg ${FEATURES:-} || return 0
	: "${PKGDIR:?missing PKGDIR}"
	addwrite "${PKGDIR}"

	portage-github-binrepo push || die "failed to push binary packages"
}

if [[ ${EBUILD_PHASE:-} != depend ]]; then
	register_success_hook _portage_github_binrepo_success
fi
