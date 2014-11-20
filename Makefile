FTLS=ft_ls
FTLSDIR=../repo

all: tests

tests: $(FTLS)
	./run_tests.sh

$(FTLS): $(FTLSDIR)
	$(MAKE) -C $(FTLSDIR)
	cp $(FTLSDIR)/$(FTLS) .

clean:
	rm -f $(FTLS)

fclean: clean
	rm -fr logs/* results

re: fclean all

.PHONY: clean fclean
