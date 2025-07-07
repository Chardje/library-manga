using labrary_manga_api.Models;
using Microsoft.AspNetCore.Mvc;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("hi")]
    public class HiController : ControllerBase
    {
        [HttpGet("{name}")]
        public ActionResult<HiModel> Get(string name)
        {
            return new HiModel { text = $"Hello, {name}!" };
        }
    }
}