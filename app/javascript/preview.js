window.addEventListener('DOMContentLoaded', (event) => {
  const input = document.getElementById('post_image_field');
  input.addEventListener('change', (event) => {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.onloadend = function() {
      const preview = document.getElementById('preview');
      if (preview) {
        preview.src = reader.result;
      }
    };
    if (file) {
      reader.readAsDataURL(file);
    }
  });
});