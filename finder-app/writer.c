#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <syslog.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[])
{
    if (argc < 3) {
        fprintf(stderr, "Error: missing parameter(s).\nUsage: %s <full-path-to-file> <string>\n", argv[0]);
        return 1;
    }

    const char *writefile = argv[1];
    const char *writestr = argv[2];

    /* open syslog with LOG_USER facility */
    openlog("writer", LOG_PID, LOG_USER);

    syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);

    /* Attempt to open the target file (overwriting any existing file) */
    int fd = open(writefile, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (fd < 0) {
        syslog(LOG_ERR, "Failed to open %s: %m", writefile);
        fprintf(stderr, "Error: could not open file %s\n", writefile);
        closelog();
        return 1;
    }

    ssize_t len = strlen(writestr);
    ssize_t written = write(fd, writestr, len);
    if (written < 0 || written != len) {
        syslog(LOG_ERR, "Failed to write to %s: %m", writefile);
        fprintf(stderr, "Error: could not write to file %s\n", writefile);
        close(fd);
        closelog();
        return 1;
    }

    if (close(fd) < 0) {
        syslog(LOG_ERR, "Failed to close %s: %m", writefile);
        fprintf(stderr, "Error: could not close file %s\n", writefile);
        closelog();
        return 1;
    }

    closelog();
    return 0;
}
