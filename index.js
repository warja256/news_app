const express = require("express");
const app = express();

const posts = [
  { id: 1, title: 'First post', body: 'This is the first post.' },
  { id: 2, title: 'Second post', body: 'This is the second post.' },
  { id: 3, title: 'Third post', body: 'This is the third post.' }
];

// Обработка GET-запроса для /posts
app.get("/posts", (req, res) => {
  res.status(200).json(posts);
});

// Логирование ошибки, если путь не найден
app.use((req, res) => {
  res.status(404).json({ message: 'Not Found' });
});

const port = process.env.PORT || 9001;

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
