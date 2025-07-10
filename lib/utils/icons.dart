String getCategoryIcon(String categoryName) {
  switch (categoryName) {
    case 'Clothes':
      return 'assets/clothes.svg';
    case 'Electronics':
      return 'assets/electronics.svg';
    case "Furniture":
      return 'assets/furniture.svg';
    case "Shoes":
      return 'assets/shoes.svg';
    case "Miscellaneous":
      return 'assets/more.svg';
    default:
      return 'assets/more.svg';
  }
}
