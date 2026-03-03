# Contributing to RevPlay

Thank you for considering contributing to RevPlay! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers
- Focus on constructive feedback
- Maintain professional communication

## How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported
2. Use the bug report template
3. Include:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Environment details (OS, browser, versions)

### Suggesting Features

1. Check if the feature has been suggested
2. Use the feature request template
3. Explain:
   - Use case
   - Expected behavior
   - Potential implementation approach

### Pull Requests

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write/update tests
5. Update documentation
6. Submit pull request

## Development Setup

### Prerequisites
- Java 17+
- Node.js 18+
- PostgreSQL 14+
- Maven 3.8+
- Git

### Setup Steps

1. **Clone Repository**
```bash
git clone https://github.com/your-username/revplay.git
cd revplay
```

2. **Setup Database**
```bash
psql -U postgres -c "CREATE DATABASE revplay;"
psql -U postgres -d revplay -f database/schema.sql
```

3. **Backend Setup**
```bash
cd backend
cp src/main/resources/application.properties.example src/main/resources/application.properties
# Update database credentials
mvn clean install
```

4. **Frontend Setup**
```bash
cd frontend
npm install
```

## Coding Standards

### Backend (Java/Spring Boot)

#### Code Style
- Follow Java naming conventions
- Use meaningful variable names
- Keep methods small and focused
- Add JavaDoc for public methods

#### Example:
```java
/**
 * Retrieves a song by its ID.
 * 
 * @param id the song ID
 * @return the song entity
 * @throws ResourceNotFoundException if song not found
 */
@GetMapping("/{id}")
public ResponseEntity<Song> getSongById(@PathVariable Long id) {
    Song song = songRepository.findById(id)
        .orElseThrow(() -> new ResourceNotFoundException("Song not found"));
    return ResponseEntity.ok(song);
}
```

#### Testing
- Write unit tests for all services
- Write integration tests for controllers
- Aim for 80%+ code coverage
- Use meaningful test names

```java
@Test
void getSongById_WhenExists_ShouldReturnSong() {
    // Arrange
    when(songRepository.findById(1L)).thenReturn(Optional.of(testSong));
    
    // Act
    ResponseEntity<Song> response = songController.getSongById(1L);
    
    // Assert
    assertEquals(HttpStatus.OK, response.getStatusCode());
    assertEquals("Test Song", response.getBody().getTitle());
}
```

### Frontend (Angular/TypeScript)

#### Code Style
- Follow Angular style guide
- Use TypeScript strict mode
- Use meaningful component/service names
- Add JSDoc comments

#### Example:
```typescript
/**
 * Service for managing music playback.
 */
@Injectable({
  providedIn: 'root'
})
export class PlayerService {
  private audio: HTMLAudioElement;
  currentSong = signal<Song | null>(null);
  
  /**
   * Plays the specified song.
   * @param song The song to play
   */
  playSong(song: Song): void {
    this.audio.src = song.audioFile;
    this.audio.play();
    this.currentSong.set(song);
  }
}
```

#### Testing
- Write unit tests for components and services
- Test user interactions
- Test error scenarios

```typescript
describe('PlayerService', () => {
  it('should play song when playSong is called', () => {
    const song = { id: 1, title: 'Test', audioFile: '/test.mp3' };
    service.playSong(song);
    expect(service.currentSong()).toEqual(song);
  });
});
```

## Git Workflow

### Branch Naming
- `feature/description` - New features
- `bugfix/description` - Bug fixes
- `hotfix/description` - Urgent fixes
- `docs/description` - Documentation updates

### Commit Messages
Follow conventional commits:

```
type(scope): subject

body (optional)

footer (optional)
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance

Examples:
```
feat(player): add volume control

Add volume slider to music player component with
mute/unmute functionality.

Closes #123
```

```
fix(auth): resolve token expiration issue

Update JWT expiration handling to properly refresh
tokens before they expire.

Fixes #456
```

### Pull Request Process

1. **Create Branch**
```bash
git checkout -b feature/my-feature
```

2. **Make Changes**
```bash
# Make your changes
git add .
git commit -m "feat(scope): description"
```

3. **Update from Main**
```bash
git fetch origin
git rebase origin/main
```

4. **Push Changes**
```bash
git push origin feature/my-feature
```

5. **Create Pull Request**
- Use PR template
- Link related issues
- Add screenshots if UI changes
- Request review

### PR Checklist
- [ ] Code follows style guidelines
- [ ] Tests added/updated
- [ ] Documentation updated
- [ ] All tests pass
- [ ] No merge conflicts
- [ ] Commits are clean and descriptive

## Testing Guidelines

### Backend Tests
```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=SongControllerTest

# Generate coverage report
mvn test jacoco:report
```

### Frontend Tests
```bash
# Run all tests
npm test

# Run with coverage
npm test -- --code-coverage

# Run specific test
npm test -- --include='**/player.service.spec.ts'
```

## Documentation

### Update Documentation When:
- Adding new features
- Changing API endpoints
- Modifying configuration
- Updating dependencies

### Documentation Files to Update:
- README.md - Main project overview
- API_DOCUMENTATION.md - API changes
- ARCHITECTURE.md - Architecture changes
- Component/Service comments - Code changes

## Review Process

### For Reviewers
- Check code quality
- Verify tests pass
- Test functionality locally
- Review documentation
- Provide constructive feedback

### For Contributors
- Address all review comments
- Update PR based on feedback
- Keep PR focused and small
- Be responsive to questions

## Release Process

1. Update version numbers
2. Update CHANGELOG.md
3. Create release branch
4. Run full test suite
5. Create release tag
6. Deploy to staging
7. Test in staging
8. Deploy to production

## Questions?

- Check documentation
- Ask in discussions
- Create an issue
- Contact maintainers

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Thank You!

Your contributions make RevPlay better for everyone!
