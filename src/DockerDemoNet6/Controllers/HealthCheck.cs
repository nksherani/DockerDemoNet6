using Microsoft.AspNetCore.Mvc;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace DockerDemoNet6.Controllers
{
    [Route("/")]
    [ApiController]
    public class HealthCheck : ControllerBase
    {
        // GET: api/<HealthCheck>
        [HttpGet]
        public IActionResult Get()
        {
            return Ok("naveed");
        }

        // GET api/<HealthCheck>/5
        [HttpGet("{id}")]
        public string Get(int id)
        {
            return "value";
        }

        // POST api/<HealthCheck>
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/<HealthCheck>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<HealthCheck>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
