import xfinity_usage.version as version
import re

class TestVersion(object):

    def test_project_url(self):
        expected = 'https://github.com/jantman/xfinity-usage'
        assert version.PROJECT_URL == expected

    def test_is_semver(self):
        # see:
        # https://github.com/mojombo/semver.org/issues/59#issuecomment-57884619
        semver_ptn = re.compile(
            r'^'
            r'(?P<MAJOR>(?:'
            r'0|(?:[1-9]\d*)'
            r'))'
            r'\.'
            r'(?P<MINOR>(?:'
            r'0|(?:[1-9]\d*)'
            r'))'
            r'\.'
            r'(?P<PATCH>(?:'
            r'0|(?:[1-9]\d*)'
            r'))'
            r'(?:-(?P<prerelease>'
            r'[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*'
            r'))?'
            r'(?:\+(?P<build>'
            r'[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*'
            r'))?'
            r'$'
        )
        assert semver_ptn.match(version.VERSION) is not None
