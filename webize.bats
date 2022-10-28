setup() {
    mkdir -p "$BATS_FILE_TMPDIR/pictures"
    touch "$BATS_FILE_TMPDIR/pictures/01.gif"
    touch "$BATS_FILE_TMPDIR/pictures/02.GIF"
    touch "$BATS_FILE_TMPDIR/pictures/03.jpg"
    touch "$BATS_FILE_TMPDIR/pictures/04.jpeg"
    touch "$BATS_FILE_TMPDIR/pictures/05.JPG"
    touch "$BATS_FILE_TMPDIR/pictures/06.JPEG"
    touch "$BATS_FILE_TMPDIR/pictures/07.png"
    touch "$BATS_FILE_TMPDIR/pictures/08.PNG"
    touch "$BATS_FILE_TMPDIR/pictures/09.svg"
    touch "$BATS_FILE_TMPDIR/pictures/10.SVG"
    touch "$BATS_FILE_TMPDIR/pictures/11.webp"
    touch "$BATS_FILE_TMPDIR/pictures/12.WEBP"
}

teardown() {
    rm -rf "$BATS_FILE_TMPDIR/pictures"
}

@test "Runs our script" {
    output=$( "$BATS_TEST_DIRNAME/webize" --help )

    echo "$output" | grep 'webize'
}

@test "Exits if subcommand is missing" {
    run "$BATS_TEST_DIRNAME/webize"

    [ "$status" = 1 ]
}

@test "gallery - Generates index.htm with correct number of images" {
    run "$BATS_TEST_DIRNAME/webize" gallery "$BATS_FILE_TMPDIR/pictures"

    [ "$status" = 0 ]
    [ -f index.htm ]
    [ -s index.htm ]
    [ $( cat index.htm | grep 'const IMAGES_CSV' -A12 | grep -Ei '(\.gif|\.jpe?g|\.png|\.svg|\.webp)$' | wc -l ) = 12 ]
}

@test "clean - Cleans index.htm" {
    touch index.htm
    run "$BATS_TEST_DIRNAME/webize" clean .

    [ "$status" = 0 ]
    [ ! -f index.htm ]
}
