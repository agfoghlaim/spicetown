document.addEventListener("DOMContentLoaded", function(){
 
  const getcontent = document.querySelector('div#getcontent');
  getcontent.addEventListener('click', getProducts);
  
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
  <div class="col-md-9 col">
      ${data.map(d => `<div class="col-md-3 col">
      <h4 class="title">${d.product.title}</h4>
      <p class="price">${d.product.price}</p>
      <img src="${d.img_url}">
      </div>` ).join('')}
  </div>
  `;
  document.querySelector('.theProducts').innerHTML = str;
  
  }
  
  