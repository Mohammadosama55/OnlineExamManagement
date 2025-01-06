
const emailInput = document.getElementById('email');
const passwordInput = document.getElementById('password');
const submitButton = document.querySelector('#login-form button[type="submit"]');
const emailErrorMessage = document.getElementById('email-error');
const passwordErrorMessage = document.getElementById('password-error');


submitButton.addEventListener('click', (event) => {
  event.preventDefault(); // Prevent the form from submitting

  // Validate the email input
  if (!validateEmail(emailInput.value)) {
    emailErrorMessage.textContent = 'Please enter a valid email address.';
    emailErrorMessage.style.display = 'block';
    return;
  } else {
    emailErrorMessage.style.display = 'none';
  }

  // Validate the password input
  if (passwordInput.value.length < 8) {
    passwordErrorMessage.textContent = 'Password must be at least 8 characters long.';
    passwordErrorMessage.style.display = 'block';
    return;
  } else {
    passwordErrorMessage.style.display = 'none';
  }

  // If all validations pass, submit the form
  event.target.form.submit();
});

// Email validation function
function validateEmail(email) {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}


// Get all navigation links
const navLinks = document.querySelectorAll('nav a');

// Add event listener to each link
navLinks.forEach(link => {
  link.addEventListener('click', () => {
    // Remove 'active' class from all links
    navLinks.forEach(l => l.classList.remove('active'));

    // Add 'active' class to the clicked link
    link.classList.add('active');
  });
});

