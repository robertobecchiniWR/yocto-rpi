# Use this function to cache a git repo in yocto download style
# Used in top Makefile to cache repos used before yocto build
# process take over.

define gitcache
	gitbase=$(shell echo $(1) | sed -nr 's#.*://##p' | tr / .) ; \
	if [ ! $(DOWNLOADS_CACHE) ]; then \
		git clone $(1) $(2) ; \
	elif [ -d $(DOWNLOADS_CACHE)/git2/$$gitbase ]; then \
		git -C $(DOWNLOADS_CACHE)/git2/$$gitbase remote update ; \
		git clone $(DOWNLOADS_CACHE)/git2/$$gitbase $(2) ; \
		git -C $(2) remote add upstream $(1) ; \
	else \
		mkdir -p $(DOWNLOADS_CACHE)/git2 ; \
		git -C $(DOWNLOADS_CACHE)/git2 clone --mirror $(1) $$gitbase ; \
		git clone $(DOWNLOADS_CACHE)/git2/$$gitbase $(2) ; \
		git -C $(2) remote add upstream $(1) ; \
	fi ; \
	chmod -R -f g+w $(2)
endef

distclean::
	$(RM) -r $(DOWNLOADS_CACHE)
