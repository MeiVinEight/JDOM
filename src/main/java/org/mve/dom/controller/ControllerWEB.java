package org.mve.dom.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Controller("WEB")
public class ControllerWEB
{
	private static final Map<String, MediaType> MEDIA_TYPE = new ConcurrentHashMap<>();
	private static final String RELATIVE = "web";

	@GetMapping("/**")
	public ResponseEntity<Resource> web(HttpServletRequest request)
	{
		return ControllerWEB.resource(request.getRequestURI());
	}

	@GetMapping("/")
	public String root()
	{
		return "redirect:/public";
	}

	@GetMapping("/login")
	public ResponseEntity<Resource> login()
	{
		return ControllerWEB.resource("/login.html");
	}

	@GetMapping("/public")
	public ResponseEntity<Resource> publicx()
	{
		return ControllerWEB.resource("/public.html");
	}

	@GetMapping("/public/team/{id}")
	public ResponseEntity<Resource> team(@PathVariable int id)
	{
		return ControllerWEB.resource("/team.html");
	}

	@GetMapping("/team")
	public ResponseEntity<Resource> team()
	{
		return ControllerWEB.resource("/team-overview.html");
	}

	@GetMapping("/team/submit")
	public ResponseEntity<Resource> submit()
	{
		return ControllerWEB.resource("/submit.html");
	}

	@PostMapping("/team/submit")
	public String submit(@RequestParam("submit_problem[code][]") MultipartFile file)
	{
//		System.out.println(file.getOriginalFilename());

		String fileName = file.getOriginalFilename();
		fileName = Optional.ofNullable(fileName).orElse(UUID.randomUUID().toString());
		try (FileOutputStream fos = new FileOutputStream("temporary/code/" + fileName))
		{
			file.getInputStream().transferTo(fos);
			fos.flush();
		}
		catch (IOException e)
		{
			e.printStackTrace(System.out);
		}
		return "redirect:/team";
	}

	@GetMapping("/submissions/{id}")
	public ResponseEntity<Resource> submission(@PathVariable int id)
	{
		return ControllerWEB.resource("/submissions.html");
	}

	public static ResponseEntity<Resource> resource(String path)
	{
		HttpStatus status = HttpStatus.OK;
		path = ControllerWEB.RELATIVE + path;
		File file = new File(path);
		if (!file.exists() || file.isDirectory())
		{
			status = HttpStatus.NOT_FOUND;
			path = ControllerWEB.RELATIVE + "/404.html";
		}
		MediaType type = MediaTypeFactory.getMediaType(path).orElse(null);
		if (type == null)
		{
			String ext = StringUtils.getFilenameExtension(path);
			if (ext != null) type = ControllerWEB.MEDIA_TYPE.get(ext);
		}
		ResponseEntity.BodyBuilder builder = ResponseEntity.status(status);
		if (type != null) builder.contentType(type);
		return builder.body(new FileSystemResource(path));
	}

	static
	{
		ControllerWEB.MEDIA_TYPE.put("woff2", MediaType.parseMediaType("font/woff2"));
	}
}
