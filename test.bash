#!/bin/bash
# SPDX-FileCopyrightText: 2025 Kaito Yagiuchi
# SPDX-License-Identifier: BSD-3-Clause

TARGET="python3 plus"

encrypt_decrypt_test() {
    plaintext="$1"
    key_index="$2"
    description="$3"

    echo "テスト: $description"

    export TEST_KEY_INDEX="$key_index"

    out=$(printf "1\n%s\n" "$plaintext" | $TARGET)
    code=$?

    if [ "$code" != "0" ]; then
        echo "  失敗: 暗号化に失敗 (終了コード=$code)"
        echo "----------------------------------"
        return
    fi

    key_index_out=$(echo "$out" | sed -n '1p')
    encrypted=$(echo "$out" | sed -n '2p')

    out2=$( (echo "2"; echo "$key_index_out"; echo "$encrypted") | $TARGET )
    code2=$?

    if [ "$code2" != "0" ]; then
        echo "  失敗: 復号に失敗 (終了コード=$code2)"
        echo "----------------------------------"
        return
    fi

    if [ "$out2" = "$plaintext" ]; then
        echo "  OK: 復号結果が一致 ($out2)"
    else
        echo "  NG: 復号結果が一致しません (期待='$plaintext', 実際='$out2')"
    fi

    echo "----------------------------------"
    unset TEST_KEY_INDEX
}

invalid_test1() {
    input="$1"
    expected_code="$2"
    description="$3"

    echo "テスト: $description"

    out=$(printf "1\n%s\n" "$input" | $TARGET 2>/dev/null)
    code=$?

    if [ "$code" = "$expected_code" ]; then
        echo "  OK (終了コード=$code)"
    else
        echo "  NG (期待=$expected_code, 実際=$code)"
        echo "  出力: '$out'"
    fi

    echo "----------------------------------"
}

invalid_test2() {
    input="$1"
    expected_code="$2"
    description="$3"

    echo "テスト: $description"

    out=$(printf "2\n0\n%s\n" "$input" | $TARGET 2>/dev/null)
    code=$?

    if [ "$code" = "$expected_code" ]; then
        echo "  OK (終了コード=$code)"
    else
        echo "  NG (期待=$expected_code, 実際=$code)"
        echo "  出力: '$out'"
    fi

    echo "----------------------------------"
}

invalid_key_test() {
    key_index="$1"
    ciphertext="ABC"
    expected_code="$2"
    description="$3"

    echo "テスト: $description"

    out=$(printf "2\n%s\n%s\n" "$key_index" "$ciphertext" | $TARGET 2>/dev/null)
    code=$?

    if [ "$code" = "$expected_code" ]; then
        echo "  OK (終了コード=$code)"
    else
        echo "  NG (期待=$expected_code, 実際=$code)"
        echo "  出力: '$out'"
    fi
    echo "----------------------------------"
}

encrypt_decrypt_test "HELLO WORLD" 3 "暗号化→復号: HELLOWORLD (キー3)"
encrypt_decrypt_test "ATTACKATDAWN" 5 "暗号化→復号: ATTACKATDAWN (キー5)"

invalid_test1 "" 2 "モード1空文字"
invalid_test1 "あいう" 3 "モード1-日本語入力"
invalid_test1 "ＡＢＣ" 3 "モード1-全角英字"
invalid_test1 "HELLO123" 4 "モード1-数字を含む"
invalid_test1 "HELLO!" 4 "モード1-記号を含む"
invalid_test2 "" 2 "モード2-空文字"
invalid_test2 "あいう" 3 "モード2-日本語入力"
invalid_test2 "ＡＢＣ" 3 "モード2-全角英字"
invalid_test2 "HELLO123" 4 "モード2-数字を含む"
invalid_test2 "HELLO!" 4 "モード2-記号を含む"

invalid_key_test "-1" 5 "キー番号が負数"
invalid_key_test "999" 5 "キー番号範囲外"
invalid_key_test "abc" 5 "キー番号が数値でない"
