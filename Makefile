TAGGED_MAJOR_MINOR_PATCH=2.2.3
INITIAL_MAJOR_MINOR_PATCH=2.2.3

################################################################################
## make helm-chart-next-version
##    Generates the next Helm Chart version (e.g., 1.0.0-21).
################################################################################
helm-chart-next-version:
	$(eval TAGGED_MAJOR=$(shell echo $(TAGGED_MAJOR_MINOR_PATCH) | awk -F. '{print $$1}'))
	$(eval TAGGED_MINOR=$(shell echo $(TAGGED_MAJOR_MINOR_PATCH) | awk -F. '{print $$2}'))
	$(eval TAGGED_PATCH=$(shell echo $(TAGGED_MAJOR_MINOR_PATCH) | awk -F. '{print $$NF}'))
	$(eval INITIAL_MAJOR=$(shell echo $(INITIAL_MAJOR_MINOR_PATCH) | awk -F. '{print $$1}'))
	$(eval INITIAL_MINOR=$(shell echo $(INITIAL_MAJOR_MINOR_PATCH) | awk -F. '{print $$2}'))
	$(eval INITIAL_PATCH=$(shell echo $(INITIAL_MAJOR_MINOR_PATCH) | awk -F. '{print $$NF}'))
	$(eval BUILD_NUMBER=$(shell echo $(INITIAL_MAJOR_MINOR_PATCH) | awk -F. '{print $$NF}'))

	$(QUIET)if [ "$(INITIAL_MAJOR_MINOR_PATCH)" = "$(TAGGED_MAJOR_MINOR_PATCH)" ]; then \
    		NEW_TAG=$(TAGGED_MAJOR_MINOR_PATCH); \
    		BUILD_NUMBER=$$(( $(TAGGED_PATCH) + 1 )); \
    	else \
    		NEW_TAG=$(INITIAL_MAJOR_MINOR_PATCH); \
    		BUILD_NUMBER=$(TAGGED_PATCH); \
    	fi; \
    echo $$NEW_TAG-$$BUILD_NUMBER;

