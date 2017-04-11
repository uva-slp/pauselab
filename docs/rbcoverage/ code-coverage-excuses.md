As of now our main code coverage is around 98.7%, with about 30 lines uncovered.  There are three main issues for those lines:

1. **else statements**- for a most of our models we have else statements when something isn't deleted correctly.  For a few of the models RSPEC wouldn't let us create a bad model and not let us delete it.  RSPEC would also not let us delete a model if it didn't exsist.
2. **gen_csv**- We are still talking with customer about what he wants exported at end of iteration.  We have code that generates CSVs for all models, but as of now we only generate three of them.  If Matthew wants mass-emails, categories, etc. exported we will include them in the export zip function, and if not we will get rid of those lines of dead code.
3. **user in devise **- Devise is a gem we've been using to make user registration easier. There is functionality in the gem that seems to prohibit RSPEC from creating, deleting users like most other models.
