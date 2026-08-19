# Copyright 2026 Konstantinos Smanis
# SPDX-License-Identifier: MIT

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12..14} )
inherit distutils-r1

DESCRIPTION="GitHub-hosted Portage binrepos"
HOMEPAGE="https://github.com/KSmanis/portage-github-binrepo"
SRC_URI="
	https://github.com/KSmanis/${PN}/releases/download/v${PV}/portage_github_binrepo-${PV}.tar.gz
"
S="${WORKDIR}/portage_github_binrepo-${PV}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	>=dev-python/requests-2.34.2[${PYTHON_USEDEP}]
	>=sys-apps/portage-3.0.81.1[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/hatch-vcs[${PYTHON_USEDEP}]
	test? (
		dev-python/inline-snapshot[${PYTHON_USEDEP}]
		dev-python/pytest-cov[${PYTHON_USEDEP}]
		dev-python/responses[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( pytest-cov )
distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install

	insinto /usr/share/portage-github-binrepo
	newins "${FILESDIR}/portage-github-binrepo.bashrc" portage-github-binrepo.bashrc

	insinto /etc/portage
	newins "${FILESDIR}/github-binrepo.conf" github-binrepo.conf
	insopts -m0600
	newins /dev/null github-binrepo.token
}

pkg_postinst() {
	elog "Usage: https://github.com/KSmanis/portage-github-binrepo#usage"
}
