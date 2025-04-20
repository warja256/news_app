module.exports = (req, res) => {
    // Симуляция данных, которые могут быть получены с базы данных
    const posts = [
      { id: 1, title: 'First post', body: 'This is the first post.' },
      { id: 2, title: 'Second post', body: 'This is the second post.' },
      { id: 3, title: 'Third post', body: 'This is the third post.' }
    ];
  
    // Обработка GET-запроса для /posts
    if (req.method === 'GET' && req.url === '/posts') {
      res.status(200).json(posts);
    } else {
      // Обработка 404 ошибок для любых других запросов
      res.status(404).json({ message: 'Not Found' });
    }
  };
  