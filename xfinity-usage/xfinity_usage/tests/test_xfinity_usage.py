from xfinity_usage.xfinity_usage import XfinityUsage


class TestXfinityUsage(object):

    def test_usage_url(self):
        """
        We don't have real unit tests yet. For now, add one to just make sure
        the class can be imported
        """
        expected = 'https://customer.xfinity.com/#/devices'
        assert XfinityUsage.USAGE_URL == expected
