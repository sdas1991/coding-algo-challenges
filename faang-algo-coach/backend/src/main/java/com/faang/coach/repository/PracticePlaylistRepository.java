package com.faang.coach.repository;

import com.faang.coach.domain.PracticePlaylist;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PracticePlaylistRepository extends JpaRepository<PracticePlaylist, Long> {

    List<PracticePlaylist> findByUserId(Long userId);

    List<PracticePlaylist> findByUserIdAndIsActive(Long userId, Boolean isActive);

    Optional<PracticePlaylist> findByUserIdAndPlaylistName(Long userId, String playlistName);
}
