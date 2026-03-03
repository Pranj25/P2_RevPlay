# Testing Documentation

## Testing Strategy

### Backend Testing

#### Unit Tests
- Test individual service methods
- Mock repository dependencies
- Test business logic in isolation
- Test JWT token generation and validation
- Test file upload validation

#### Integration Tests
- Test API endpoints with MockMvc
- Test database operations
- Test security configurations
- Test exception handling

**Tools:**
- JUnit 5
- Mockito
- Spring Boot Test
- H2 in-memory database for testing

**Running Tests:**
```bash
cd backend
mvn test
```

**Test Coverage:**
```bash
mvn test jacoco:report
```

**Example Test Structure:**
```java
@SpringBootTest
@AutoConfigureMockMvc
class SongControllerTest {
    @Autowired
    private MockMvc mockMvc;
    
    @MockBean
    private SongRepository songRepository;
    
    @Test
    void getAllSongs_ShouldReturnSongList() throws Exception {
        mockMvc.perform(get("/api/songs"))
            .andExpect(status().isOk());
    }
}
```

### Frontend Testing

#### Unit Tests
- Test component logic
- Test service methods
- Test pipes and directives
- Test player functionality

#### Integration Tests
- Test component interactions
- Test routing
- Test HTTP calls

**Tools:**
- Jasmine
- Karma
- Angular Testing Utilities

**Running Tests:**
```bash
cd frontend
npm test
```

**Example Test Structure:**
```typescript
describe('SongsComponent', () => {
  let component: SongsComponent;
  let fixture: ComponentFixture<SongsComponent>;
  
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [SongsComponent]
    });
    fixture = TestBed.createComponent(SongsComponent);
    component = fixture.componentInstance;
  });
  
  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
```

## Manual Testing Checklist

### Authentication
- [ ] User registration (User role)
- [ ] User registration (Artist role)
- [ ] Login with email
- [ ] Login with username
- [ ] Invalid credentials handling
- [ ] JWT token generation
- [ ] Protected route access

### Songs
- [ ] View all songs
- [ ] View song details
- [ ] Upload song (Artist)
- [ ] Play song
- [ ] Search songs
- [ ] Filter by genre

### Albums
- [ ] View all albums
- [ ] View album details
- [ ] Create album (Artist)
- [ ] Add songs to album

### Playlists
- [ ] Create playlist
- [ ] Add songs to playlist
- [ ] Remove songs from playlist
- [ ] Delete playlist
- [ ] Public/private toggle
- [ ] Follow public playlist

### Favorites
- [ ] Add song to favorites
- [ ] Remove from favorites
- [ ] View all favorites

### Profile
- [ ] View profile
- [ ] Update profile
- [ ] View statistics

## API Testing

Use tools like Postman or curl to test endpoints:

```bash
# Register
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","username":"testuser","password":"password123"}'

# Login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"emailOrUsername":"testuser","password":"password123"}'

# Get songs (with token)
curl http://localhost:8080/api/songs \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

## Performance Testing

- Load testing with JMeter or Gatling
- Database query optimization
- Frontend bundle size analysis
- API response time monitoring

## Security Testing

- SQL injection prevention
- XSS protection
- CSRF protection
- JWT token validation
- Password strength requirements
- Role-based access control

## Test Coverage Goals

- Backend: 80%+ code coverage
- Frontend: 70%+ code coverage
- Critical paths: 100% coverage
