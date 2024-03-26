document.addEventListener('DOMContentLoaded', function () {
  const dropdownContainer = document.getElementById('dropdown-container');
  const dropdownMenu = document.getElementById('dropdown-menu');

  function showDropdownMenu() {
    dropdownMenu.classList.remove('hidden');
    dropdownContainer.classList.add('rounded-tl-md', "rounded-tr-md", 'bg-white');
  }

  function hideDropdownMenu() {
    dropdownMenu.classList.add('hidden');
    dropdownContainer.classList.remove('rounded-tl-md', "rounded-tr-md", 'bg-white');
  }

  const burgerBtn = document.getElementById('burger-btn');
  burgerBtn.addEventListener('click', function () {
    if (dropdownMenu.classList.contains('hidden')) {
      showDropdownMenu();
    } else {
      hideDropdownMenu();
    }
  });

  document.addEventListener('click', function (event) {
    if (!event.target.closest('#burger-btn') && !event.target.closest('#dropdown-menu')) {
      hideDropdownMenu();
    }
  });
});
