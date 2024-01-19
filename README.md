# Learning Continuous Integration with Jenkins

<a href="https://www.packtpub.com/product/learning-continuous-integration-with-jenkins-third-edition/9781835087732"><img src="https://m.media-amazon.com/images/I/71GBCRlkwAL._SY425_.jpg" alt="Book Name" height="256px" align="right"></a>

This is the code repository for [Learning Continuous Integration with Jenkins](https://www.packtpub.com/product/learning-continuous-integration-with-jenkins-third-edition/9781835087732), published by Packt.

**An end-to-end guide to creating operational, secure, resilient, and cost-effective CI/CD processes**

## What is this book about?
This updated edition of Learning Continuous Integration with Jenkins is your one-stop guide to implementing CI/CD with Jenkins, addressing crucial technologies such as cloud computing, containerization, Infrastructure as Code, and GitOps. Tailored to both beginners and seasoned developers, the book provides a practical path to mastering a production-grade, secure, resilient, and cost-effective CI/CD setup.

This book covers the following exciting features: 
* Understand CI with the Golden Circle theory
* Deploy Jenkins on the cloud using Helm charts and Jenkins Configuration as Code (JCasC)
* Implement optimal security practices to ensure Jenkins operates securely
* Extend Jenkins for CI by integrating with SonarQube, GitHub, and Artifactory
* Scale Jenkins using containers and the cloud for optimal performance
* Enhance security and improve pipeline code within your CI/CD process using best practices

If you feel this book is for you, get your [copy](https://www.amazon.com/Learning-Continuous-Integration-Jenkins-end/dp/1835087736) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders. For example, Chapter04.

The commands will look like the following:
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm show values sonarqube/sonarqube > sonarqube-values.yaml
```

**Following is what you need for this book:**
This book is for a diverse audience, from university students studying Agile software development to seasoned developers, testers, release engineers, and project managers. If you’re already using Jenkins for CI, this book will assist you in elevating your projects to CD. Whether you’re new to the concepts of Agile, CI, and CD, or a DevOps engineer seeking advanced insights into JCasC, IaC, and Azure, this book will equip you with the tools to harness Jenkins for improved productivity and streamlined deliveries in the cloud.

With the following software and hardware list you can run all code files present in the book (Chapter 1-12).

### Software and Hardware List

| Chapter  | Software required                                                              | OS required                        |
| -------- | ------------------------------------------------------------------------------ | -----------------------------------|
| 1-12     | Microsoft Azure, Visual Studio Code, Helm, Git, kubectl, Terraform, Azure CLI  | Windows, Mac OS X, and Linux (Any) |


### Related products <Other books you may enjoy>
* The Linux DevOps Handbook [[Packt]](https://www.packtpub.com/product/the-linux-devops-handbook/9781803245669) [[Amazon]](https://www.amazon.com/Linux-DevOps-Handbook-distributions-accelerate/dp/1803245662)

* Containers for Developers Handbook [[Packt]](https://www.packtpub.com/product/containers-for-developers-handbook/9781805127987) [[Amazon]](https://www.amazon.com/Containers-Developers-Handbook-developing-applications/dp/1805127985)

## Get to Know the Author

**Nikhil Pathania**
He is a tech expert with deep knowledge in the Software Development Lifecycle (SDLC) domain. His professional identity is shaped by his specialization in Agile methodologies, DevOps practices, cloud technologies, and container solutions. His significant contributions, particularly in implementing CI/CD frameworks at multinational corporations, underline his expertise in optimizing complex software development processes.
In his current role as a solutions architect at Arla Foods, Nikhil spearheads innovative projects in software development and data analytics, reflecting his keen insight into technological advancements and their practical applications.

# Extra info about Learning Continuous Integration with Jenkins - Third Edition

## Introduction
This repository contains the source code for the examples, configurations and excersises demonstrated for this book. Each code file is organized chapter-wise to help you navigate through them easily. 

## How to Use This Repository

### 1. Fork the Repository
Please fork this repository to have your own version of the code. This allows you to make changes and experiment.

### 2. Navigate the Code
The code files are organized chapter-wise inside each folder named `/chapter-1`, `/chapter-2`, ..., etc. This makes it easier for you to find the relevant code for each section of the book.

### 3. Note on Chapters 8 and 9
The code files for chapters 8 and 9 are the same.

### 4. Refer to the Respective Chapters
Before using the code, make sure to refer to the respective chapters in the book. This will provide you with the necessary background information and instructions on how to effectively use the code examples.

### 5. Replace Placeholder Values
In some code files, you'll find placeholder values denoted by `<...>`. Make sure to replace these with your setup-specific details. For example, replace `<Artifactory Server IP Address>` with your Artifactory server's IP address or URL.

### 6. Deploy in a Sandbox Environment
Before deploying the "Hello World 3-Tier Application" code, along with other scripts found in this repository, it's crucial to use a **sandbox environment**. A sandbox environment is a safe, isolated setup where you can run and test code without affecting your actual system or data. Always review and understand the code and its requirements before deploying it to any environment other than sandbox.

This practice is particularly important for:

- Understanding how the application and scripts behave.
- Ensuring there are no unforeseen side effects or issues.
- Protecting your production environment from potential errors during the learning and experimentation phase.


Thank you for using this repository, and I hope it effectively aids in your learning and development!
