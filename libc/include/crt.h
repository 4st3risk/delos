# ifndef _CRT_H
# define _CRT_H 1

# include <sys/cdefs.h>

# ifdef __cplusplus
extern "C" {
# endif

__attribute__((noreturn))
void __stack_chk_fail(void);

# ifdef __cplusplus
}
# endif

# endif

