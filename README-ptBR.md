<p align="center">
  <a href="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_icon.png">
    <img alt="BossExperts" src="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_icon.png">
  </a>
</p>

# Boss Experts
Boss Experts é um utilitário IDE para instalação em Delphi que visa facilitar o uso do Boss sem precisar sair do IDE Delphi.

## Instalação
1. Basta baixar [Boss Experts](https://github.com/gabrielbaltazar/boss-experts/releases)
2. Descompacte o arquivo Source code.zip
3. Abra o Delphi e depois o arquivo <b>BossExperts.dproj</b>
4. Compile e instale o pacote no Project Manager

Pronto!

> Se você estiver usando Delphi XE5, abra o projeto BossExperts_XE.dproj e siga os passos de instalação

## Uso
Usar <b>Boss Experts</b> é bem simples. Uma vez instalado, um menu de contexto aparecerá ao clicar com o botão direito em qualquer projeto no <i>Project Manager</i>. Localize o menu Boss e seus submenus.

As opções disponíveis são:

<ul>
   <li><b>Init</b>: inicializa o gerenciamento de dependências em seu projeto. </li>
   <li><b>Install</b>: instala dependências no projeto. </li>
   <li><b>Update</b>: atualiza as dependências no projeto</li>
   <li><b>Uninstall</b>: desinstala dependências no projeto</li>
   <li><b>Dependencies</b>: abre a janela do gerenciador de dependências</li>
   <li><b>Remove Cache</b>: remove o histórico de dependência</li>
</ul>

## Menu de Dependências
Clicar em Dependências abrirá a janela do utilitário, como mostra a imagem abaixo 👇

<p align="center">
  <a href="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_janela.png">
    <img alt="BossExperts" src="https://github.com/gabrielbaltazar/boss-experts/tree/master/Source/Images/boss_experts_janela.png">
  </a>
</p>

## ⚡️ Início rápido
Para começar a gerenciar dependências em seu projeto, siga as etapas abaixo:

1. Clique com o botão direito do mouse no nome do seu projeto no Project Manager.
2. Selecione <b>Boss > Init</b>
3. Clique com o botão direito do mouse em seu projeto novamente e selecione <b>Boss > Dependencies</b>

O Boss Experts suporta GitHub, GitLab e Bitbucket. Selecione no ComboBox qual serviço você irá utilizar.

Digite o caminho completo do repositório que você deseja instalar em seu projeto através do campo <b>Dependencie</b>.

Por fim, clique em <b>Install</b>. Pronto!

Repita o processo se houver outras dependências que você deseja instalar.

## 🥇 Atualizando dependências
Para atualizar todas as dependências do seu projeto, clique em <b>Update</b>.
Os Boss Experts pesquisarão novas versões de cada dependência e as atualizarão automaticamente.

## ⛔ Desinstalando dependências
Para desinstalar uma dependência em seu projeto, selecione uma dependência e clique em <b>Uninstall</b>.

## 🔐 Login
Clique em Login se desejar fazer login em um respositório privado.


## Idiomas da documentação
[Inglês (en)](https://github.com/gabrielbaltazar/boss-experts/tree/master/README.md)<br>
[Português (ptBR)](https://github.com/gabrielbaltazar/boss-experts/tree/master/README-ptBR.md)<br>

## ⚠️ Licença
`Boss Experts` é uma biblioteca gratuita e de código aberto licenciada sob a [Licença MIT](https://github.com/gabrielbaltazar/boss-experts/tree/master/LICENSE.md).