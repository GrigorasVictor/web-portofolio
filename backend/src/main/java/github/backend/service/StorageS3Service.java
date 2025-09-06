package github.backend.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.ResponseInputStream;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;

import java.io.IOException;
import java.util.Map;

@Service
public class StorageS3Service {

    @Value("${filebase.endpoint}")
    private String filebaseEndpoint;

    @Value("${filebase.bucket.name}")
    private String bucketName;

    @Autowired
    private S3Client s3Client;

    public byte[] getObject(String name) throws IOException {
        GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                .bucket(bucketName)
                .key(name)
                .build();

        ResponseInputStream<GetObjectResponse> s3ObjectStream = s3Client.getObject(getObjectRequest);
        return s3ObjectStream.readAllBytes();
    }
}
