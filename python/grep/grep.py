def grep(pattern, flags, files):
    line_numbers = "-n" in flags
    only_filenames = "-l" in flags
    case_insensitive = "-i" in flags
    invert = "-v" in flags
    entire_lines = "-x" in flags
    multiple_files = len(files) > 1
    ret = []

    for filename in files:
        with open(filename) as f:
            valid_lines = []

            for i, line in enumerate(f.readlines()):
                line = line.strip()
                pattern_ = pattern.lower() if case_insensitive else pattern
                line_ = line.lower() if case_insensitive else line
                if (line_ == pattern_ if entire_lines else pattern_ in line_) ^ invert:
                    if line_numbers:
                        line = str(i + 1) + ":" + line
                    if multiple_files:
                        line = filename + ":" + line
                    valid_lines.append(line + "\n")

            if only_filenames and valid_lines != []:
                ret.append(filename + "\n")
            else:
                ret.extend(valid_lines)

    return "".join(ret)
