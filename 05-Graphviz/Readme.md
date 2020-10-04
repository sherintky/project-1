# Configuring the GraphViz Utility with Apache.

## Install Apache & GraphViz Package
```
 apt-get install graphviz -y
 apt-get install apache2 -y
```

## Go the resource folder in order to gernrate terraform graph.
```
  cd 04-Resources/
  terraform graph > resource.dot

```

## Convert the resoure Dot to SVG Formate
```
dot resource.dot -Tsvg -o resource.svg
```

## Setup Apache for hosting Graphviz Images

```
  mkdir -p /var/www/html/Terraform-Images
  cp -rf resource.svg /var/www/html/Terraform-Images/01-resource.svg
  apachectl start
  ip addr 
```

## Now Explore in browser. 
