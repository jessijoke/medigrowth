const menuButton = document.getElementsByClassName("menu_button")[0];
const navBarLinks = document.getElementsByClassName('wrapper')[0];
const acctButtons = document.getElementsByClassName('account_buttons')[0];

menuButton.addEventListener('click', () => {
    navBarLinks.classList.toggle('active');
    acctButtons.classList.toggle('active');
  })
