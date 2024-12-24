// document.addEventListener('DOMContentLoaded', () => {
// 	const filterBtn = document.getElementById('filter-btn');

// 	filterBtn.addEventListener('click', () => {
// 		const minPrice = document.getElementById('filter-min-price').value;
// 		const maxPrice = document.getElementById('filter-max-price').value;

// 		const params = new URLSearchParams();

// 		if (minPrice) params.append('min_price', minPrice);
// 		if (maxPrice) params.append('max_price', maxPrice);

// 		fetch('/products/filter.json?${params.toString()}', {
// 			headers: {
// 				'X-Requested-With': 'XMLHttpRequest'
// 			}
// 		})
// 			.then(response => {
// 				if (!response.ok) throw new Error('Network response was not ok');
// 				return response.json();
// 			})
// 			.then(data => {
// 				const productsList = document.getElementById('products-list');
// 				if (data.length > 0) {
// 					productsList.innerHTML = '<tr>' + data.map(product => 
// 						'<td>${product.name}</td>  <td>${product.price}</td>  <td>${product.sku_id}</td>'
// 					).join('') + '</tr>';
// 				} else {
// 					productsList.innerHTML = '<p>No products found with the selected filters.</p>';
// 				}
// 			})
// 			.catch(error => {
// 				console.error('Error:', error);
// 			});
// 	});
// });