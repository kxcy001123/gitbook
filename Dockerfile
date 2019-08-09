FROM gitbook:0.0.1
EXPOSE 4000
CMD cd gitbook && gitbook serve
