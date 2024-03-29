setup() {
    mkdir -p "$BATS_FILE_TMPDIR/pictures"
    mkdir -p "$BATS_FILE_TMPDIR/pictures/child"
    touch "$BATS_FILE_TMPDIR/pictures/01.gif"
    touch "$BATS_FILE_TMPDIR/pictures/02.GIF"
    touch "$BATS_FILE_TMPDIR/pictures/03.jpg"
    touch "$BATS_FILE_TMPDIR/pictures/04.jpeg"
    touch "$BATS_FILE_TMPDIR/pictures/05.JPG"
    touch "$BATS_FILE_TMPDIR/pictures/06.JPEG"
    touch "$BATS_FILE_TMPDIR/pictures/child/07.png"
    touch "$BATS_FILE_TMPDIR/pictures/child/08.PNG"
    touch "$BATS_FILE_TMPDIR/pictures/child/09.svg"
    touch "$BATS_FILE_TMPDIR/pictures/child/10.SVG"
    touch "$BATS_FILE_TMPDIR/pictures/child/11.webp"
    touch "$BATS_FILE_TMPDIR/pictures/child/12.WEBP"
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

@test "webize gallery - Generates index.htm" {
    "$BATS_TEST_DIRNAME/webize" gallery "$BATS_FILE_TMPDIR/pictures" | grep index.htm

    [ -f "$BATS_FILE_TMPDIR/pictures/index.htm" ]
    [ -s "$BATS_FILE_TMPDIR/pictures/index.htm" ]
    [ $( cat "$BATS_FILE_TMPDIR/pictures/index.htm" | grep 'const IMAGES_CSV' -A12 | grep -Ei '(\.gif|\.jpe?g|\.png|\.svg|\.webp)' | wc -l ) = 12 ]
}

@test "webize clean - Cleans index.htm" {
    touch "$BATS_FILE_TMPDIR/pictures/index.htm"
    "$BATS_TEST_DIRNAME/webize" clean "$BATS_FILE_TMPDIR/pictures" | grep index.htm

    [ ! -f "$BATS_FILE_TMPDIR/pictures/index.htm" ]
}

@test "webize gallery --scoped - Generates index.htm in each descendent folder" {
    "$BATS_TEST_DIRNAME/webize" gallery "$BATS_FILE_TMPDIR/pictures" --scoped | grep index.htm

    [ -f "$BATS_FILE_TMPDIR/pictures/index.htm" ]
    [ -s "$BATS_FILE_TMPDIR/pictures/index.htm" ]
    [ $( cat "$BATS_FILE_TMPDIR/pictures/index.htm" | grep 'const IMAGES_CSV' -A6 | grep -Ei '(\.gif|\.jpe?g|\.png|\.svg|\.webp)' | wc -l ) = 6 ]
    [ -f "$BATS_FILE_TMPDIR/pictures/child/index.htm" ]
    [ -s "$BATS_FILE_TMPDIR/pictures/child/index.htm" ]
    [ $( cat "$BATS_FILE_TMPDIR/pictures/index.htm" | grep 'const IMAGES_CSV' -A6 | grep -Ei '(\.gif|\.jpe?g|\.png|\.svg|\.webp)' | wc -l ) = 6 ]
}

@test "webize clean --scoped - Cleans index.htm in each descendent folder" {
    touch "$BATS_FILE_TMPDIR/pictures/index.htm"
    touch "$BATS_FILE_TMPDIR/pictures/child/index.htm"
    "$BATS_TEST_DIRNAME/webize" clean "$BATS_FILE_TMPDIR/pictures" --scoped | grep index.htm

    [ ! -f "$BATS_FILE_TMPDIR/pictures/index.htm" ]
    [ ! -f "$BATS_FILE_TMPDIR/pictures/child/index.htm" ]
}
