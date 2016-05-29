using UnityEngine;
using System.Collections;

public class StanControl : MonoBehaviour {

	public AudioClip startSound;
	public AudioClip movingSound;
	public AudioClip endSound;
	public AudioClip end2Sound;

	public Material headMat;
	public Texture defaultTex;
	public Texture talkTex;

	public LightAnimation mainPotal; 

	public FirstPersonControl Player;

	private AudioSource audio;

	private int count = 0;
	private bool isTalk = false;
	private IEnumerator loopingIEnum;
	private Animator anim;


	void Start () {
		audio = GetComponent<AudioSource> ();
		anim = GetComponent<Animator>();

		loopingIEnum = Looping (0.2F);
		StartCoroutine(loopingIEnum);
		DefaultTexture ();

	}
	
	// Update is called once per frame
	void Update () {
		if (20f > Vector3.Distance (gameObject.transform.position, Player.transform.position)) {
			Vector3 pos = Player.gameObject.transform.position;
			pos.y = transform.position.y;

			gameObject.transform.LookAt (pos);
		}
	}

	//animation
	void StartWalk(){
		anim.SetBool ("Walk", true);
	}
	void StopWalk(){
		anim.SetBool ("Walk", false);
	}

	public void StartWand(){
		anim.SetTrigger ("Wand");
	}


	public void playStartSound(){
		TalkTexture ();
		audio.PlayOneShot (startSound);
		StartCoroutine(TalkEnd(startSound.length));
	}

	public void playMovingSound(){
		TalkTexture ();
		audio.PlayOneShot (movingSound);
		StartCoroutine(TalkEnd(movingSound.length));
	}

	public void playEndSound(){
		TalkTexture ();
		audio.PlayOneShot (endSound);
		StartCoroutine(TalkEnd(endSound.length));

		StartCoroutine(MoveForward(endSound.length+1f));
	}

	IEnumerator MoveForward(float waitTime){
		yield return new WaitForSeconds (waitTime);


		StartWalk ();

		Vector3 pos = transform.position + transform.forward * 2f;
		LeanTween.move (gameObject, pos, 2.0f).setOnComplete(MoveComplete);

		StartCoroutine(MoveCompleteNext(3.0f));
	}

	void MoveComplete(){
		StopWalk ();


	}



	IEnumerator MoveCompleteNext(float waitTime){
		yield return new WaitForSeconds (waitTime);
		TalkTexture ();
		audio.PlayOneShot (end2Sound);
		StartCoroutine(TalkEnd(end2Sound.length));
		
		StartCoroutine(MainPotal(end2Sound.length + 1f));
	}

	IEnumerator MainPotal(float waitTime){
		yield return new WaitForSeconds (waitTime);
		mainPotal.OnPotal ();

		anim.SetBool ("Hand", true);

		//anim.SetBool ("Hand", false);
	}

	public void TalkTexture() {
		isTalk = true;
		headMat.mainTexture = talkTex;
		headMat.mainTextureScale = new Vector2 (0.33333f, 1f);
		headMat.mainTextureOffset = new Vector2 (0f, 0f);
	}

	public void DefaultTexture() {
		isTalk = false;
		headMat.mainTexture = defaultTex;
		headMat.mainTextureScale = new Vector2 (0.5f, 1f);
		headMat.mainTextureOffset = new Vector2 (0f, 0f);
	}

	public void MoveFinishPosition(GameObject obj){
		Vector3 pos = obj.transform.position;
		pos.y = transform.position.y;
		transform.position = pos;
	}

	IEnumerator TalkEnd(float waitTime) {
		yield return new WaitForSeconds (waitTime);
		DefaultTexture ();

	}


	IEnumerator Looping(float waitTime) {

		while (true) {


			yield return new WaitForSeconds (waitTime);

			Vector2 vec2 = new Vector2 (0f, 0);

			if(isTalk){
				if (count >= 3) {
					count = 0;
				}

				if (count == 0) {
					vec2 = new Vector2 (0f, 0);
				} else if (count == 1) {
					vec2 = new Vector2 (0.33333f, 0f);
				} else if (count == 2) {
					vec2 = new Vector2 (0.66666f, 0f);
				}

			}else{
				if (count == 10) {
					count = 0;
				}

				if (count == 1) {
					vec2 = new Vector2 (0.5f, 0f);
				} else {
					vec2 = new Vector2 (0f, 0f);
				}
			}


			headMat.mainTextureOffset = vec2;
			count++;

		}
	}
	
}
