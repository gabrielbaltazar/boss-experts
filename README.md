<p align="center">
  <a href="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_icon.png">
    <img alt="BossExperts" src="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_icon.png">
  </a>  
</p>

# Boss Experts
Boss Experts is an IDE utility for installation in Delphi that aims to facilitate the use of Boss without having to leave the Delphi IDE.

## Installation
1. Just download [Boss Experts](https://github.com/gabrielbaltazar/boss-experts/releases)
2. Unzip the Source code.zip file
3. Open Delphi and then the <b>BossExperts.dproj</b> file
4. Build and Install the package in the Project Manager

Ready!

> If you are using Delphi XE5, open the BossExperts_XE.dproj project and follow the installation steps

## Use
Using <b>Boss Experts</b> is quite simple. Once installed, a context menu will appear when right-clicking on any project in <i>Project Manager</i>. Locate the Boss menu and its submenus.

The available options are:

<ul>
   <li><b>Init</b>: Initializes dependency management in your project. </li>
   <li><b>Install</b>: Installs dependencies in the project. </li>
   <li><b>Update</b>: Updates dependencies in the project</li>
   <li><b>Uninstall</b>: Uninstalls dependencies in the project</li>
   <li><b>Dependencies</b>: Opens the dependency manager window</li>
   <li><b>Remove Cache</b>: Removes dependency history</li>
</ul>

## Dependencies Menu
Clicking on Dependencies will open the utility window, as shown in the image below 👇

<p align="center">
  <a href="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_janela.png">
    <img alt="BossExperts" src="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_janela.png">
  </a>  
</p>

## ⚡️ Quickstart
To start managing dependencies in your project, follow the steps below:

1. Right-click on your project name in the Project Manager.
2. Select <b>Boss > Init</b>
3. Right-click your project again and select <b>Boss > Dependencies</b>

Boss Experts supports GitHub, GitLab and Bitbucket. Select in the ComboBox which service you will use. 

Enter the full path of the repository you want to install in your project through the <b>Dependency</b> field.

Finally, click <b>Install</b>. Ready!

Repeat the process if there are other dependencies you want to install.

## 🥇 Updating Dependecies

To update all dependencies in your project, click in <b>Update</b>. 
Boss Experts will search for new versions of each dependency and update them automatically.

## ⛔ Uninstalling Dependencies
To unistall a dependency in yout project, select a dependency and click in <b>Uninstall</b>.

## 🔐 Login
Click Login if you want to login to a private repository.


## Documentation Languages
[English (en)](https://github.com/gabrielbaltazar/boss-experts/tree/master/README.md)<br>
[Português (ptBR)](https://github.com/gabrielbaltazar/boss-experts/tree/master/README-ptBR.md)<br>

## ⚠️ License
`Boss Experts` is free and open-source library licensed under the [MIT License](https://github.com/gabrielbaltazar/boss-experts/tree/master/LICENSE.md). 