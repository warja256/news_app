// Импортируем express
const express = require("express");

// Инициализируем приложение express
const app = express();

// Подключаем middleware для парсинга JSON
app.use(express.json());

// Пример данных
const posts = [
  { id: 1, title: 'First post', body: 'This is the first post.' },
  { id: 2, title: 'Second post', body: 'This is the second post.' },
  { id: 3, title: 'Third post', body: 'This is the third post.' }
];

// Обрабатываем запрос GET для /api/posts
app.get("/api/posts", (req, res) => {
  res.status(200).json(posts);
});

// Указываем порт напрямую
const port = 9001;

// Запускаем сервер
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
