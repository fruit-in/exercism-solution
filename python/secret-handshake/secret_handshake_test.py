import unittest

from secret_handshake import commands

# Tests adapted from `problem-specifications//canonical-data.json`


class SecretHandshakeTest(unittest.TestCase):
    def test_wink_for_1(self):
        self.assertEqual(commands(1), ["wink"])

    def test_double_blink_for_10(self):
        self.assertEqual(commands(2), ["double blink"])

    def test_close_your_eyes_for_100(self):
        self.assertEqual(commands(4), ["close your eyes"])

    def test_jump_for_1000(self):
        self.assertEqual(commands(8), ["jump"])

    def test_combine_two_actions(self):
        self.assertEqual(commands(3), ["wink", "double blink"])

    def test_reverse_two_actions(self):
        self.assertEqual(commands(19), ["double blink", "wink"])

    def test_reversing_one_action_gives_the_same_action(self):
        self.assertEqual(commands(24), ["jump"])

    def test_reversing_no_actions_still_gives_no_actions(self):
        self.assertEqual(commands(16), [])

    def test_all_possible_actions(self):
        self.assertEqual(
            commands(15), ["wink", "double blink", "close your eyes", "jump"]
        )

    def test_reverse_all_possible_actions(self):
        self.assertEqual(
            commands(31), ["jump", "close your eyes", "double blink", "wink"]
        )

    def test_do_nothing_for_zero(self):
        self.assertEqual(commands(0), [])


if __name__ == "__main__":
    unittest.main()
