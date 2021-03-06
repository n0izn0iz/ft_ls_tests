FTLS=ft_ls
FTLSDIR=../ft_ls

all: tests

tests: $(FTLS)
	./run_tests.sh

testgen: tests_generator.c
	gcc -o $@ -Wall -Wextra -Werror $^

$(FTLS): $(FTLSDIR)
	$(MAKE) re -C $(FTLSDIR)
	cp $(FTLSDIR)/$(FTLS) .

clean:
	rm -f $(FTLS)

fclean: clean
	rm -fr logs/* results

re: fclean all

.PHONY: clean fclean
