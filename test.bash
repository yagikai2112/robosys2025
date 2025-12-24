#!/bin/bash
# SPDX-FileCopyrightText: 2025 Kaito Yagiuchi
# SPDX-License-Identifier: BSD-3-Clause


TARGET="./vigenere"

encrypt_decrypt_test() {
    plaintext="$1"
    key_index="$2"

    export TEST_KEY_INDEX="$key_index"

    out=$(printf "1\n%s\n" "$plaintext" | $TARGET)
    code=$?

    if [ "$code" != "0" ]; then
        exit 1
    fi

    key_index_out=$(echo "$out" | sed -n '1p')
    encrypted=$(echo "$out" | sed -n '2p')

    out2=$(printf "2\n%s\n%s\n" "$key_index_out" "$encrypted" | $TARGET)
    code2=$?

    if [ "$code2" != "0" ]; then
        exit 1
    fi

    if [ "$out2" != "$plaintext" ]; then
        exit 1
    fi

    unset TEST_KEY_INDEX
}

encrypt_decrypt_space_trim_test() {
    input="$1"
    key_index="$2"

    expected="$(printf "%s" "$input" | sed 's/^ *//; s/ *$//')"

    export TEST_KEY_INDEX="$key_index"

    out=$(printf "1\n%s\n" "$input" | $TARGET)
    code=$?
    [ "$code" != "0" ] && { unset TEST_KEY_INDEX; exit 1; }

    key_index_out=$(echo "$out" | sed -n '1p')
    encrypted=$(echo "$out" | sed -n '2p')

    out2=$(printf "2\n%s\n%s\n" "$key_index_out" "$encrypted" | $TARGET)
    code2=$?
    [ "$code2" != "0" ] && { unset TEST_KEY_INDEX; exit 1; }

    trimmed_out2="$(printf "%s" "$out2" | sed 's/^ *//; s/ *$//')"

    [ "$trimmed_out2" = "$expected" ] || { unset TEST_KEY_INDEX; exit 1; }

    unset TEST_KEY_INDEX
}

invalid_test1() {
    input="$1"
    expected_code="$2"

    printf "1\n%s\n" "$input" | $TARGET >/dev/null
    code=$?

    if [ "$code" != "$expected_code" ]; then
        exit 1
    fi
}

invalid_test2() {
    input="$1"
    expected_code="$2"

    printf "2\n0\n%s\n" "$input" | $TARGET >/dev/null
    code=$?

    if [ "$code" != "$expected_code" ]; then
        exit 1
    fi
}

invalid_key_test() {
    key_index="$1"
    ciphertext="ABC"
    expected_code="$2"

    printf "2\n%s\n%s\n" "$key_index" "$ciphertext" | $TARGET >/dev/null
    code=$?

    if [ "$code" != "$expected_code" ]; then
        exit 1
    fi
}

encrypt_decrypt_test "HELLO WORLD" 3
encrypt_decrypt_test "ATTACKATDAWN" 5
encrypt_decrypt_test "THIS IS A TEST" 1
encrypt_decrypt_test "THE QUICK BROWN FOX" 4
encrypt_decrypt_test "JUMPS OVER THE LAZY DOG" 2
encrypt_decrypt_test "ABCDEFGHIJKLMNOPQRSTUVWXYZ" 0
encrypt_decrypt_test "A SIMPLE MESSAGE" 7
encrypt_decrypt_test "CRYPTOGRAPHY TEST" 8
encrypt_decrypt_test "VIGENERE CIPHER CHECK" 9
encrypt_decrypt_test "INFORMATION SECURITY" 2
encrypt_decrypt_test "PYTHON SCRIPT RUN" 4
encrypt_decrypt_test "SPACE INSIDE OK" 6
encrypt_decrypt_test "MULTIPLE   SPACES" 3
encrypt_decrypt_test "EDGE CASE INPUT" 1
encrypt_decrypt_test "SAMPLE TEXT HERE" 8
encrypt_decrypt_test "DATA ENCRYPTION" 5
encrypt_decrypt_test "COMPUTER SCIENCE" 7
encrypt_decrypt_test "HELLO" 3
encrypt_decrypt_test "WORLD" 4
encrypt_decrypt_test "AAAAA" 0
encrypt_decrypt_test "BBBBB" 1
encrypt_decrypt_test "ZZZZZ" 2
encrypt_decrypt_test "UPPERCASE ONLY" 3
encrypt_decrypt_test "MIXED LETTER CASE" 6
encrypt_decrypt_test "WITH SMALL LETTERS" 2
encrypt_decrypt_test "TRY LOWERCASE too" 4
encrypt_decrypt_test "CAPITAL and small MIX" 5
encrypt_decrypt_test "CHECK   SPACE  PATTERN" 7
encrypt_decrypt_test "VIGENERE CIPHER LONG LONG TEXT" 9
encrypt_decrypt_test "TEST WITH KEY ZERO" 0
encrypt_decrypt_test "TEST WITH KEY ONE" 1
encrypt_decrypt_test "TEST WITH KEY TWO" 2
encrypt_decrypt_test "TEST WITH KEY THREE" 3
encrypt_decrypt_test "TEST WITH KEY FOUR" 4
encrypt_decrypt_test "TEST WITH KEY FIVE" 5
encrypt_decrypt_test "TEST WITH KEY SIX" 6
encrypt_decrypt_test "TEST WITH KEY SEVEN" 7
encrypt_decrypt_test "TEST WITH KEY EIGHT" 8
encrypt_decrypt_test "TEST WITH KEY NINE" 9
encrypt_decrypt_test "LONGTEXT WITHOUT SPACE" 2
encrypt_decrypt_test "SENTENCE WITH SEVERAL WORDS TEST" 6
encrypt_decrypt_test "SINGLE" 5
encrypt_decrypt_test "DOUBLE  SPACE" 3
encrypt_decrypt_test "TRIPLE   SPACE" 2
encrypt_decrypt_test "THE LAST TEST IN LIST" 9

encrypt_decrypt_space_trim_test " HELLO" 3
encrypt_decrypt_space_trim_test "HELLO WORLD " 4
encrypt_decrypt_space_trim_test " robosys " 5
encrypt_decrypt_space_trim_test "   manaba" 2
encrypt_decrypt_space_trim_test "   citportal   " 2
encrypt_decrypt_space_trim_test "slack   " 2
encrypt_decrypt_space_trim_test "ATTACK AT DAWN" 5
encrypt_decrypt_space_trim_test "A B C D E" 1
encrypt_decrypt_space_trim_test "   THIS IS A VERY LONG MESSAGE   " 0 

invalid_test1 "" 2
invalid_test1 " " 2
invalid_test1 "     " 2
invalid_test1 "　" 2
invalid_test1 "あいう" 3
invalid_test1 "ＡＢＣ" 3
invalid_test1 "１２３" 3
invalid_test1 "漢字テスト" 3
invalid_test1 "éclair" 3
invalid_test1 "ß" 3
invalid_test1 "Ωmega" 3
invalid_test1 "HELLO123" 4
invalid_test1 "HELLO!" 4
invalid_test1 "!@#$%" 4
invalid_test1 "abc!" 4
invalid_test1 "hello-world" 4
invalid_test1 "a b c !" 4
invalid_test1 "abc?" 4
invalid_test1 "test." 4
invalid_test1 "A B C 1" 4
invalid_test1 "ABC123!" 4
invalid_test1 "a1b2c3" 4
invalid_test1 "h e l l o !" 4
invalid_test1 "endswith-" 4
invalid_test1 "-startswith" 4
invalid_test1 "ab--cd" 4

invalid_test2 "" 2
invalid_test2 " " 2
invalid_test2 "     " 2
invalid_test2 "あいう" 3
invalid_test2 "ＡＢＣ" 3
invalid_test2 "１２３" 3
invalid_test2 "日本語文章" 3
invalid_test2 "FULLWIDTHＡ" 3
invalid_test2 "ΩMEGA" 3
invalid_test2 "HELLO123" 4
invalid_test2 "HELLO!" 4
invalid_test2 "???" 4
invalid_test2 "abc!!!" 4
invalid_test2 "hello." 4
invalid_test2 "123" 4
invalid_test2 "abc123" 4
invalid_test2 "ABC_ABC" 4
invalid_test2 "test?" 4
invalid_test2 "hello-world" 4
invalid_test2 "-start" 4
invalid_test2 "end-" 4
invalid_test2 "a b c 1" 4
invalid_test2 "12 AB" 4
invalid_test2 "ab cd!" 4
invalid_test2 "a1" 4
invalid_test2 "t e s t !" 4
invalid_test2 "ABC DEF!" 4
invalid_test2 "A1B2" 4
invalid_test2 "hello!" 4

invalid_key_test "10" 5
invalid_key_test "-1" 5
invalid_key_test "-10" 5
invalid_key_test "999" 5
invalid_key_test "1000000" 5
invalid_key_test "abc" 5
invalid_key_test "A" 5
invalid_key_test "A1" 5
invalid_key_test "０１" 5
invalid_key_test "４" 5
invalid_key_test " " 5
invalid_key_test "" 5
invalid_key_test "   " 5
invalid_key_test "1 2" 5
invalid_key_test "１２３" 5
invalid_key_test "!@#" 5
invalid_key_test "0.5" 5
invalid_key_test "1,000" 5
invalid_key_test "+10" 5
invalid_key_test "--1" 5
invalid_key_test "++1" 5
invalid_key_test "key5" 5
invalid_key_test "NO" 5
invalid_key_test "index" 5
invalid_key_test "five" 5
invalid_key_test "ten" 5
invalid_key_test "-999999" 5
invalid_key_test "2147483647" 5
invalid_key_test "-2147483648" 5
invalid_key_test "18446744073709551615" 5
invalid_key_test "0x10" 5
invalid_key_test "0b1010" 5
invalid_key_test "1e3" 5
invalid_key_test "nan" 5
invalid_key_test "inf" 5

exit 0
