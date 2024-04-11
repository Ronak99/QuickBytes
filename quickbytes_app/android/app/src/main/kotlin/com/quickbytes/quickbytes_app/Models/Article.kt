import com.quickbytes.quickbytes_app.Models.NewsCategory
import kotlinx.serialization.*

@Serializable
data class Article (
    val id: String,
    val title: String,
    val content: String,
    val image: String,

    @SerialName("published_on")
    val publishedOn: String,

    @SerialName("categories")
    val categories: List<NewsCategory>,

    @SerialName("source_url")
    val sourceURL: String
)
