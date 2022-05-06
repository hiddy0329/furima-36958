document.addEventListener("DOMContentLoaded", () => {
const tagNameInput = document.querySelector("#item_form_tag_name");
  if (tagNameInput){
    const inputElement = document.getElementById("item_form_tag_name");
    inputElement.addEventListener("input", () => {
      const keyword = document.getElementById("item_form_tag_name").value;
      console.log(keyword);
    });
  };
});