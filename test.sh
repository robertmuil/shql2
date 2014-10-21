#!/bin/sh
#
# This file is in the public domain. It is intended to be a helper for shql.
# Test shql using the files test.sql and test.out.
# Output of the test will be sent to result.txt.
#
# For more information email LoranceStinson AT gmail DOT com.

# Make sure the necessary files exist.
[ ! -x "shql" -o ! -r "test.sql" -o ! -r "test.out" ] &&
    echo "shql, test.sql and test.out must be present." && exit 1;

# Create the database.
mkdir testdb
[ $? != 0 ] &&
    echo "Please remove the directory testdb." && exit 1;

# Run the test.
cat test.sql | ./shql ./testdb > result.txt 2>&1

# See if the test passed.
diff test.out result.txt > /dev/null 2>&1
[ $? != 0 ] &&
    echo "Test failed." &&
    echo "Please email LoranceStinson AT gmail DOT com the following" &&
    echo "1) The current version of shql you have installed." &&
    echo "2) The contents of result.txt." &&
    echo "3) The operating system you are using" &&
    echo "4) The versions of the following utilities. " &&
    echo "   awk, expr, grep, join, sed, sh, sort, test and uniq" && exit;
