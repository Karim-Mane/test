
suppressPackageStartupMessages(require("devtools"))
suppressPackageStartupMessages(require("usethis"))
suppressPackageStartupMessages(require("pkgdown"))
suppressPackageStartupMessages(require("covr"))

#' function to a repository and R package
#' @param package.name the name of the package that you need to create
#' @param where the path to the folder where you want to create the package
#' @param organisation.name the name of the organisation in which the package should be created. For Epiverse TRACE, this is "epiverse-trace"
#' @examples createPackage(package.name="mypackage", where="/Users/km28/Documents/Karim/Karim/LSHTM/Codes", organisation.name="Karim-Mane")
#' @export
createPackage = function(package.name, where, organisation.name=NULL){
    setwd(where)
    cat("\nMaking the R project\n")
    devtools::create(package.name)
    cat("\nInitialising the git repository\n")
    setwd(paste0(where,"/",package.name))
    cat("\nCreating the remote git repository\n")
    if(!is.null(organisation.name)){
        system(sprintf("gh repo create --public %s/%s",organisation.name,package.name))
    }else{
        system(sprintf("gh repo create --public %s",package.name))
    }
    # cat("\nsetting the default remote branch for the current local branch\n")
    # system(sprintf("git push --set-upstream origin %s",main.name))
    system(sprintf("git init"))
    git = paste0("https://github.com/",organisation.name,"/",package.name,".git")
    system(sprintf("git remote add origin %s", git))
    system(sprintf("git add ."))
    system(sprintf("git commit -a -m \"create package\""))
    system(sprintf("git push origin master"))
    cat("\nDo not forget to manually fill in the NAMESPACE and DESCRIPTION files\n")
}

#createPackage(package.name, where, organisation.name)

#' function to set up the R package components (licence, README, pkgdown website)
#' @examples setUpPackageComponents()
#' @export
setUpPackageComponents = function(){
    cat("\nSetting a licence\n")
    usethis::use_mit_license()
    cat("\nmaking a README page\n")
    usethis::use_readme_rmd()
    cat("\nSetting up unit testing infrastructure\n")
    usethis::use_testthat()
    usethis::use_test("basic-test")
    cat("\nSetting up a pkgdown website\n")
    usethis::use_pkgdown()
}

#' function to build and update Readme.md file
#' @examples updateReadMe()
#' @export
updateReadMe = function(){
    devtools::build_readme()
}

#' function to build the pkgdown website
#' @examples buildPkgdownWebsite()
#' @export
buildPkgdownWebsite = function(){
    pkgdown::build_site()
}

#' function to add a list of packages dependencies
#' @param dependencies a vector of packages on which the package to be built depends on
#' @examples addPkgDepencies(dependencies=c("data.table","dplyr"))
#' @export
addPkgDepencies = function(dependencies="data.table"){
    usethis::use_package(dependencies)
}

