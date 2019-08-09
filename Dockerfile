FROM gitbook:0.0.1
EXPOSE 4000
CMD git clone git@github.com:kxcy001123/gitbook.git && gitbook serve
