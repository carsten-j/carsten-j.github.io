---
layout: post
title: Using Terraform as part of the Azure Devops Pipelines
---

check grammarly as native app for macOS.

I am exploring Azure Devops and Azure Functions. [Jason Roberts](https://twitter.com/robertsjason) has a great series about continuous deployment of [Azure Functions using Azure Pipelines]( http://dontcodetired.com/blog/post/Azure-Functions-Continuous-Deployment-with-Azure-Pipelines-Part-1-Overview). It is a prerequisite for the tutorial that you manually create 2 Azure Functions.

Can this part be automated and integrated into the pipeline? I believe the answer is yes. Here I will explore how to use [Terraform](https://www.terraform.io/) to achieve this. If you are new to Terraform I recommend the book ["Terraform: Up & Running"](https://www.terraformupandrunning.com/) by Yevgeniy Brikman. The first chapter has a detailed explanation that will get you up to speed with Terraform.

This blog post is not intented as a detailed tutorial on either Azure Devops nor Terraform. My aim is merely to document the steps taken to integrate and automate the setup of Azure Functions as part of the pipeline.

The first step is to be able to call Terraform in an automated way through e.g. a build server. The Terraform [documentaion](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_certificate.html) list 4 ways of achieving this. For this scenario it seems most appropriate to use a Azure Service Principal and a Client Certificate as outlined [here](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_certificate.html). If you are new to [openssl](https://www.openssl.org/)[^1] and certificated then please read this [article](https://www.digitalocean.com/community/tutorials/openssl-essentials-working-with-ssl-certificates-private-keys-and-csrs) from DigitalOcean. Information on how to create a service principal can be found in the offical Azure [documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal).

On macOS it is easy to install Terraform using Homebrew - simply 
```bash
brew install terraform
```
and checking the installation went well with
```bash
terraform --version
```

One of the cool features for Terraform is that you apply changes and not the entire infrastructure. So if I create a storage account and want to upgrade the storage account to V2 then Terraform will detect the change and simply apply that. For this to work Terraform keeps track of the state in a local file called ...   How will this work on a build server? Fortunately Terraform can use other storage backend that the file system for keeping track of state. On Azure one can use a storage account as backend storage for Terraform state. But this seems to introduce a bootstrapping problem. We want to use Terraform to create the Azure infrastructure but at the same time an Azure storage account is needed for storing the Terraform state. I manually created a storage account specifically for this purpose. Please let me know if you know of a solution to this problem. The storage account was created locally with this [config file](insert link to gist).

Now we are ready to use Terraform from Azure Devops. On the Visual Studio marketplace there is a [number](https://marketplace.visualstudio.com/search?term=terraform&target=AzureDevOps&category=All%20categories&sortBy=Relevance) of extensions for using Terraform a part of the Azure Pipeline. I simply went for the most [popular](https://marketplace.visualstudio.com/items?itemName=petergroenewegen.PeterGroenewegen-Xpirit-Vsts-Release-Terraform) one. clicking "Get it free" will open the Azure Devops portal where you select the organization for which you want to install the extension.

Starting from the pipeline defines by Jason Roberts is his series about continuous deployment of Azure Functions using Azure Pipelines I simply added an extra Terraform task 
image
with the following settings:
image

Please refer to Github for the Terraform config file used to setup the Azure Functions apps. I could not get the Terraform backend storage to work by specifying the storage account in the task settings. [Others](https://github.com/XpiritBV/Xpirit-Vsts-Release-Terraform/issues/12) have suggested specifying this as part of the configuration file as this works fine.

### Footnotes
[^1]: If you are using a new version of macOS then you will by default be using a different version of openssl than the open source version. You can install the open source version using homebrew, e.g. `brew install openssl@1.1`. The 1.1 is to install the latest LTS release. Please make sure that your path is setup in such a way that homebrew directories takes presedence over built in binary directories.
