import '../../../places/place_repository/models/place/place.dart';
import '../../../reviews/review_repository/models/review.dart';

const String loginHeaderText = 'Todo lo que buscas, en un solo lugar.';
const String googleSignInText = 'Register with Google';
const String turboIconLogIn = 'assets/images/Turbo Marca 7.svg';
const String emailText = 'Email';
const String emailHintFormText = 'Please provide your email';
const String passwordText = 'Password';
const String passwordHintText = 'Please provide a strong password';
const String nameText = 'Name';
const String nameHintText = 'Tell us your name';
const String account = 'Already have an account?';
const String noaccount = 'Do not have an account?';
final List<Place> places = [
  Place(
    rating: 4,
    id: 1,
    name: "La Guarida",
    description:
        "Uno de los restaurantes más icónicos de La Habana, famoso por su cocina gourmet y su ambiente elegante.",
    address: "Concordia 418, La Habana, Cuba",
    averagePrice: 25.0,
    imageUrls: [
      "https://www.istockphoto.com/br/foto/coliseu-em-roma-e-o-sol-da-manh%C3%A3-it%C3%A1lia-gm539115110-96048731",
      "https://images.unsplash.com/photo-1593394886166-bbde9bda2d72?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjUyOXwwfDF8c2VhY2h8NXx8bWFjaHUlMjBwaWNjaHUlMjBhdH0%3D&ixlib=rb-1.2.1&q=80&w=1080",
    ],
    reviews: [
      Review(
        id: 1,
        userName: "Carlos Pérez",
        userAvatar: "https://randomuser.me/api/portraits/men/1.jpg",
        comment: "Excelente comida y una vista impresionante de La Habana.",
        rating: 4.8,
        date: DateTime(2024, 1, 15),
      ),
      Review(
        id: 2,
        userName: "Ana Rodríguez",
        userAvatar: "https://randomuser.me/api/portraits/women/2.jpg",
        comment: "La atención fue de primera y el ambiente mágico.",
        rating: 5.0,
        date: DateTime(2024, 2, 10),
      ),
    ],
  ),
  Place(
    id: 2,
    rating: 5,
    name: "Fábrica de Arte Cubano",
    description:
        "Un espacio cultural vibrante que combina arte, música y gastronomía en un solo lugar.",
    address: "Calle 26, Vedado, La Habana, Cuba",
    averagePrice: 15.0,
    imageUrls: [
      "https://images.unsplash.com/photo-1594596335666-e19a69f8e216?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjUyOXwwfDF8c2VhY2h8MjN8fHBsYXphJTIwbWF5b3J8ZW58MHx8fHwxNjc4NzA3NTc1&ixlib=rb-1.2.1&q=80&w=1080",
      "https://images.unsplash.com/photo-1618951130933-b649084f44fc?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjUyOXwwfDF8c2VhY2h8MjN8fHBsYXphJTIwbWF5b3J8ZW58MHx8fHwxNjc4NzA3NTc1&ixlib=rb-1.2.1&q=80&w=1080",
    ],
    reviews: [
      Review(
        id: 3,
        userName: "Luis Fernández",
        userAvatar: "https://randomuser.me/api/portraits/men/3.jpg",
        comment:
            "El mejor lugar en La Habana para disfrutar de la cultura cubana moderna.",
        rating: 4.9,
        date: DateTime(2024, 3, 5),
      ),
      Review(
        id: 4,
        userName: "María Gómez",
        userAvatar: "https://randomuser.me/api/portraits/women/4.jpg",
        comment:
            "Arte increíble y buena música en vivo, un sitio imprescindible.",
        rating: 4.7,
        date: DateTime(2024, 3, 20),
      ),
    ],
  ),
  Place(
    id: 3,
    rating: 3.5,
    name: "Varadero Beach",
    description:
        "Una de las playas más hermosas del mundo, con arena blanca y aguas cristalinas.",
    address: "Varadero, Matanzas, Cuba",
    averagePrice: 0.0, // Es una playa pública
    imageUrls: [
      "https://images.unsplash.com/photo-1534404989302-ffb2ff12a27c?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjUyOXwwfDF8c2VhY2h8MXx8dG9ycmUlMjBlZmZlbHxlbnwwfHx8fDE2Nzg3MDEwNzE&ixlib=rb-1.2.1&q=80&w=1080",
      "https://images.unsplash.com/photo-1594700531398-c95c3a9c9e1d?crop=entropy&cs=tinysrgb&fit=max&ixid=MnwzNjUyOXwwfDF8c2VhY2h8MXx8dG9ycmUlMjBlZmZlbHxlbnwwfHx8fDE2Nzg3MDEwNzE&ixlib=rb-1.2.1&q=80&w=1080",
    ],
    reviews: [
      Review(
        id: 5,
        userName: "José Martínez",
        userAvatar: "https://randomuser.me/api/portraits/men/5.jpg",
        comment: "El agua es simplemente increíble, perfecta para relajarse.",
        rating: 5.0,
        date: DateTime(2024, 4, 1),
      ),
      Review(
        id: 6,
        userName: "Elena Sánchez",
        userAvatar: "https://randomuser.me/api/portraits/women/6.jpg",
        comment: "Una de las mejores playas que he visitado en mi vida.",
        rating: 5.0,
        date: DateTime(2024, 4, 10),
      ),
    ],
  ),
];
