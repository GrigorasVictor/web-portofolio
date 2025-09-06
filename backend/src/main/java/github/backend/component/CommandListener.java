package github.backend.component;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.function.Consumer;

@Component
public class CommandListener implements CommandLineRunner {
    private static final Logger logger = LoggerFactory.getLogger(CommandListener.class);
    private final Map<String, Consumer<String[]>> commandMap = new HashMap<>();
    private final DatabaseMapper database;

    private boolean isRunning = true;

    @Autowired
    public CommandListener(DatabaseMapper database) {
        this.database = database;

        // Initialize commandMap with commands and their corresponding actions
        commandMap.put("!ping", args -> logger.info("pong"));
        commandMap.put("!help", args -> {
                                    logger.info("Available commands:");
                                    for (String command : commandMap.keySet()) {
                                        logger.info(" - {}", command);
                                    }});
        commandMap.put("!exit", args -> isRunning = false);
        commandMap.put("!put", args -> {
                    if (args.length < 3) {
                        logger.error("Usage: !put <file_path>  <entity_type>");
                        return;
                    }

                    // Extract parameters directly from the args array
                    String filePath = args[1];
                    String entityType = args[2];

                    logger.info("Attempting to process: file={}, entity={}", filePath, entityType);
                    this.database.mapFileToEntity(filePath, entityType);
        });
    }

    @Override
    public void run(String... args) {
        Thread listenerThread = new Thread(() -> {
            Scanner scanner = new Scanner(System.in);
            logger.info("Command Listener is running. Type !help for available commands.");

            while (isRunning) {
                String input = scanner.nextLine().trim();
                if (input.isEmpty()) continue;

                String[] commandParts = input.split("\\s+");
                String command = commandParts[0];

                Consumer<String[]> action = commandMap.get(command);
                if (action != null) {
                    action.accept(commandParts);
                } else {
                    logger.warn("Unknown command: {}. Type !help for available commands.", command);
                }
            }
            scanner.close();
            logger.info("Command listener stopped.");
        });

        listenerThread.setDaemon(true);
        listenerThread.start();
    }
}