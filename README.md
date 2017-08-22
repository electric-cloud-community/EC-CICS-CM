# EC-CICS-CM

This plugin allows to work with CICS CM


# Procedures

## Backout change package

Backout a change package to reverse a migration event

## Create migration scheme

Dynamically create a migration scheme with a single migration path

## Install change package

Install the resource definitions in a change package from a CSD configuration



# Building the plugin
1. Download or clone the EC-CICS-CM repository.

    ```
    git clone https://github.com/electric-cloud/EC-CICS-CM.git
    ```

5. Zip up the files to create the plugin zip file.

    ```
     cd EC-CICS-CM
     zip -r EC-CICS-CM.zip ./*
    ```

6. Import the plugin zip file into your ElectricFlow server and promote it.
