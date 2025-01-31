help:: sstate.help

sstate.help:
	$(Q)echo -e "\n--- sstate ---"
	$(Q)echo -e "sstate-update             : update $(SSTATE_MIRROR) with contents from $(SSTATE_LOCAL)"

sstate-update:
	$(Q)find $(SSTATE_LOCAL) -type l -delete
	$(Q)find $(SSTATE_LOCAL) -type f -name "*.done" -delete
	$(Q)chmod -R g-w $(SSTATE_LOCAL)
	$(Q)mkdir -p $(SSTATE_MIRROR)
	$(Q)rsync -a $(SSTATE_LOCAL)/ $(SSTATE_MIRROR)
	$(Q)chmod g+w -R $(SSTATE_MIRROR)

distclean::
	$(RM) -r $(SSTATE_MIRROR)
