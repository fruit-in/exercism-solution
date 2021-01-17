import unittest

from minesweeper import annotate

# Tests adapted from `problem-specifications//canonical-data.json`


class MinesweeperTest(unittest.TestCase):
    def test_no_rows(self):
        self.assertEqual(annotate([]), [])

    def test_no_columns(self):
        self.assertEqual(annotate([""]), [""])

    def test_no_mines(self):
        self.assertEqual(annotate(["   ", "   ", "   "]), ["   ", "   ", "   "])

    def test_minefield_with_only_mines(self):
        self.assertEqual(annotate(["***", "***", "***"]), ["***", "***", "***"])

    def test_mine_surrounded_by_spaces(self):
        self.assertEqual(annotate(["   ", " * ", "   "]), ["111", "1*1", "111"])

    def test_space_surrounded_by_mines(self):
        self.assertEqual(annotate(["***", "* *", "***"]), ["***", "*8*", "***"])

    def test_horizontal_line(self):
        self.assertEqual(annotate([" * * "]), ["1*2*1"])

    def test_horizontal_line_mines_at_edges(self):
        self.assertEqual(annotate(["*   *"]), ["*1 1*"])

    def test_vertical_line(self):
        self.assertEqual(annotate([" ", "*", " ", "*", " "]), ["1", "*", "2", "*", "1"])

    def test_vertical_line_mines_at_edges(self):
        self.assertEqual(annotate(["*", " ", " ", " ", "*"]), ["*", "1", " ", "1", "*"])

    def test_cross(self):
        self.assertEqual(
            annotate(["  *  ", "  *  ", "*****", "  *  ", "  *  "]),
            [" 2*2 ", "25*52", "*****", "25*52", " 2*2 "],
        )

    def test_large_minefield(self):
        self.assertEqual(
            annotate([" *  * ", "  *   ", "    * ", "   * *", " *  * ", "      "]),
            ["1*22*1", "12*322", " 123*2", "112*4*", "1*22*2", "111111"],
        )

    # Additional tests for this track
    def test_annotate_9(self):
        self.assertEqual(
            annotate(["     ", "   * ", "     ", "     ", " *   "]),
            ["  111", "  1*1", "  111", "111  ", "1*1  "],
        )

    def test_different_len(self):
        with self.assertRaisesWithMessage(ValueError):
            annotate([" ", "*  ", "  "])

    def test_invalid_char(self):
        with self.assertRaisesWithMessage(ValueError):
            annotate(["X  * "])

    # Utility functions
    def assertRaisesWithMessage(self, exception):
        return self.assertRaisesRegex(exception, r".+")


if __name__ == "__main__":
    unittest.main()
