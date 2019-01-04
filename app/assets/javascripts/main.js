document.addEventListener("DOMContentLoaded", function(){
 
  //const getcontent = document.querySelector('div#getcontent');
  //getcontent.addEventListener('click', getProducts);
  
  function getProducts(e){
      e.preventDefault()
       //console.log(e.target.parentNode, e.target.parentNode.href)
       //const theId = e.target.parentNode.href;
       const theId = e.target.id;
       //console.log("gotid ", theId)
       const promise = fetch(`/categories/${theId}/get_products`)
      // const promise = fetch(e.target.parentNode.href)
       .then(checkStatus)
       .then(getJSON)
       .then(function(data){
           return renderData(data);
       })
       .catch(function(err){
        //hand over to rails
        //cant do this here, no nested routes so rails cant handle the situation- TODO - rails plan B 
        //getcontent.removeEventListener('click', getProducts);  
       })
   }
   });
  
  function getJSON(res){
      return res.json();
  }
  
  function checkStatus(res){
      if(res.status === 200 ){
          return Promise.resolve(res);
      }else{
          return Promise.reject(
              new Error(res.status)
          );
      }
  }

  
  
  function renderData(data){
  console.log("render got data ", data)
  const str = `
  
      ${data.map(d => `<div class="col col-md-4 col-sm-4 col-lg-4" id="${d.product.id}">
      <h3 class="title">${d.product.title}</h3>
      <p class="price">${d.product.price}</p>
      <img class="img-thumbnail" src="${d.img_url}">
      <p>${d.product.description}</p>
      <p>${d.product.price}</p>
      <a href="${window.location.href}products/${d.product.id}">Read More</a>
      </div>` ).join('')}
  
  `;
  document.querySelector('.theProducts').innerHTML = str;

    //add event listener to addToCartButton (just created)
    const addToCart = document.querySelector('#addToCart');
    addToCart.addEventListener('click', function(){console.log("work?")})
  
  }



