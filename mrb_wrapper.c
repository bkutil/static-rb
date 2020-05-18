#include <mruby.h>
#include <mruby/irep.h>
#include "mrb_bytecode.c"

int
main(void)
{
  int return_value = 0;

  mrb_state *mrb = mrb_open();
  mrb_load_irep(mrb, mrb_bytecode);

  if (mrb->exc) {
    mrb_print_error(mrb);
    return_value = 1;
  }

  mrb_close(mrb);

  return return_value;
}
